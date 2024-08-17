# Use an official Python runtime as a parent image
FROM public.ecr.aws/lambda/python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install any needed dependencies
RUN pip install --no-cache-dir -r requirements.txt -t ${LAMBDA_TASK_ROOT}
RUN yum install -y git

# Copy the Python script and any other necessary files to the container
COPY src/index.py ${LAMBDA_TASK_ROOT}

CMD ["index.lambda_handler"]