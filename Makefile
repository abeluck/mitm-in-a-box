
$(shell pwd)/certs/mitmproxy-ca-cert.cer:
	@mkdir -p $(shell pwd)/certs
	@mitmdump --confdir $(shell pwd)/certs --listen-port 1 2> /dev/null || echo "Certs generated in $(shell pwd)/certs"

gencerts: $(shell pwd)/certs/mitmproxy-ca-cert.cer

clean:
	@cd certs; rm mitmproxy-ca-cert.cer  mitmproxy-ca-cert.p12  mitmproxy-ca-cert.pem  mitmproxy-ca.pem  mitmproxy-dhparam.pem mitmproxy-ca.p12

default: gencerts
