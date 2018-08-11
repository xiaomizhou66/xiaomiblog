all: blog

blog:
	docker build -t xiaomizhou/blog .
	bash run_script
