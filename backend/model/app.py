import os
from flask import Flask, request, jsonify, url_for
from ultralytics import YOLO
from PIL import Image, ImageDraw
from inference_sdk import InferenceHTTPClient
from flask_cors import CORS

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Load the Malaria detection model
malaria_model = YOLO("malaria.pt")


# Define class labels
stage = ['M_Rg', 'M_Trp', 'Rg', 'Sz', 'Trp']


@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    
    try:
        uploads_dir = os.path.join("static", "uploads")
        os.makedirs(uploads_dir, exist_ok=True)

        img = Image.open(file)
        img_path = os.path.join(uploads_dir, file.filename)
        img.save(img_path)
        
        detection_model=malaria_model
        confidence_threshold = 0.70 

        results = detection_model.predict(source=img)
        predictions = []
        draw = ImageDraw.Draw(img)

        has_valid_prediction = False
        
        # Log the raw results
        print(f"Raw results: {results}")  # Debug log
        # Run model prediction


        for result in results:
            for box in result.boxes:
                class_name = result.names[box.cls[0].item()]
                confidence = round(box.conf[0].item(), 2)
                bbox = [round(coord, 2) for coord in box.xyxy[0].tolist()]

                # Log the individual predictions
                print(f"Detected: {class_name}, Confidence: {confidence}, BBox: {bbox}")  # Debug log

                if confidence >= confidence_threshold:
                    predictions.append({
                        'class': class_name,
                        'confidence': confidence,
                        'box': bbox
                    })
                    has_valid_prediction = True

                    # Draw the bounding box on the image
                    draw.rectangle(bbox, outline="red", width=3)
                    draw.text((bbox[0], bbox[1]), f"{class_name} {confidence}", fill="red")



        # Log predictions before returning
        print(f"Predictions: {predictions}")

         # Save the result image with bounding boxes
        img_filename = f"detected_{file.filename}"
        img_path = os.path.join(uploads_dir, img_filename)
        img.save(img_path)

        if has_valid_prediction:
            return jsonify({
                'predictions': predictions,
                'image_url': url_for('static', filename=f"uploads/{img_filename}", _external=True),
                'message': "Predictions successful."
    })
        else:
            return jsonify({'predictions': [], 'message': "No valid predictions found."})

    except Exception as e:
        return jsonify({'error': f"Error processing image: {str(e)}"}), 500


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True, reloader_type='stat')
