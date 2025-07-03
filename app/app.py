from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, World! This is Usama's DevOps portfolio app. and so much more! Plus his family and friends! <3"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
