#!/usr/bin/env python

from http.server import HTTPServer, SimpleHTTPRequestHandler
from ssl import SSLContext, PROTOCOL_TLS_SERVER
import sys

ADDRESS = '0.0.0.0'
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8000
SSL_DIR = '/home/Acervans/SSL'

class CORSRequestHandler(SimpleHTTPRequestHandler):

    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')

        SimpleHTTPRequestHandler.end_headers(self)

if __name__ == '__main__':
    try:
        sslctx = SSLContext(PROTOCOL_TLS_SERVER)
        sslctx.load_cert_chain(certfile=f'{SSL_DIR}/ssl-cert.pem', keyfile=f'{SSL_DIR}/ssl-key.pem')

        httpd = HTTPServer((ADDRESS, PORT), CORSRequestHandler)
        httpd.socket = sslctx.wrap_socket(httpd.socket, server_side=True)

        print(f"Serving HTTPS on {ADDRESS} port {PORT} (https://{ADDRESS}:{PORT}/) ...")
        httpd.serve_forever()

    except KeyboardInterrupt:
        print("\nKeyboard interrupt received, exiting.")
        sys.exit(0)