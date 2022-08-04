NAME=$(notdir ${PWD})

build:
	docker build -t arkaitzj/${NAME} --target ${NAME} . 

run:
	docker run -it --rm arkaitzj/${NAME}

push:
	docker push arkaitzj/${NAME}
