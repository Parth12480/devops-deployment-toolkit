"""Small HTTP service used by the deployment lab."""
import os
from flask import Flask, jsonify

def create_app():
    app = Flask(__name__)
    app.config["APP_VERSION"] = os.getenv("APP_VERSION", "0.1.0")

    @app.get("/")
    def index():
        return jsonify(service="enterprise-devops-demo",
                       message="Deployment toolkit is running",
                       version=app.config["APP_VERSION"])

    @app.get("/health")
    def health():
        return jsonify(status="healthy"), 200

    @app.get("/ready")
    def ready():
        # Add real dependency checks here when the service gains dependencies.
        return jsonify(status="ready"), 200

    @app.get("/version")
    def version():
        return jsonify(version=app.config["APP_VERSION"]), 200

    return app

app = create_app()
