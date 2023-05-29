#! /bin/bash

export TC_DYNAMO_TABLE=Candidates

cd /home/ec2-user/; gunicorn -b 0.0.0.0 app:candidates_app