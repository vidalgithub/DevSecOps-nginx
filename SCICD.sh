			#!/bin/bash
			set -e # means the script will quit out if any of my command return a non-zero exit code 
			
			APP_NAME=mywebapp
			VERSION=INSECURE
			
			#BUILD: Clenaup old container/build image
			docker rm -f $APP_NAME 2>/dev/null || true
			docker build -t $APP_NAME:$VERSION . 
			# Run docker scout and generate a file with all vulnerabilities in it. We then set up Jenkins (or Github Actions) to send it through email or as a slack attachment in your pipeline.
			docker scout cves $APP_NAME:$VERSION --outut ./vulns.report  
			# Run docker scout again and set a treshhold
			docker scout cves $APP_NAME:$VERSION --only-severity critical --exit-code
			
			#TEST: Run the container
      docker run -d -p 8182:80 --name webapp $APP_NAME:$VERSION 
