from app.main import create_app

def make_client():
    app = create_app()
    app.config["TESTING"] = True
    return app.test_client()

def test_home():
    response = make_client().get("/")
    assert response.status_code == 200
    assert response.get_json()["service"] == "enterprise-devops-demo"

def test_health():
    response = make_client().get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}

def test_readiness():
    response = make_client().get("/ready")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ready"

def test_version():
    response = make_client().get("/version")
    assert response.status_code == 200
    assert response.get_json()["version"] == "0.1.0"
