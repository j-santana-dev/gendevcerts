ifndef image_name
override image_name = gendevcerts
endif
build:
	docker build -t $(image_name) .

ifndef c_name
override c_name = devcert
endif
run:
	bash -c './run_on_docker.sh $(image_name) $(c_name)'

clean:
	bash -c 'rm -fv generated_certs/*.{crt,key,csr,srl}'