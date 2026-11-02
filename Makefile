.PHONY: install test run image
install:
	python -m pip install -r requirements-dev.txt
test:
	pytest -q
run:
	python -m flask --app app.main run --host 0.0.0.0 --port 8080
image:
	docker build -t devops-demo:local .
