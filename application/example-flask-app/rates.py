from flask import Flask, jsonify


def create_app():
    """Creat the server application"""
    app = Flask(__name__)

    # Make JSON output pretty by default
    app.config["JSONIFY_PRETTYPRINT_REGULAR"] = True

    @app.route("/")
    def hello_world():
        return jsonify({
            "message": "Hello world!"
        })
    
    return app
