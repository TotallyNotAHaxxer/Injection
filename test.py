import os, sys
import urllib
import urllib.request

url = input("[~] Need A Target URL >>> ")

res = urllib.request.urlopen(url+"cat=1")
body = res.read()
fullbody = body.decode('utf-8')

if "you have an error in your sql syntax;" in fullbody:
    print("[!] Website is classical injectable")
if "warning: mysql" in fullbody:
    print("[!] Website IS injectable")
if "unclosed quotation mark after the character string" in fullbody:
    print("[!] Web")
if "quoted string not properly terminated" in fullbody:
    print("[!] yay it is")
else:
    print("nah")