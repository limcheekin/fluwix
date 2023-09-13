# file_upload

## Overview

Are you in search of the perfect file upload widget to meet your specific requirements? Look no further! Introducing the File Upload module, a solution born out of the need for a versatile and tailored file uploading tool.

A picture is worth a thousand words:
![File Upload Screenshots](https://raw.githubusercontent.com/limcheekin/fluwix/file_upload/file_upload/images/screenshots.jpg "File Upload Screenshots")

The File Upload module offers support for various file upload statuses, ensuring a seamless experience:

- **pending**: Files are in a queue, waiting for upload.
- **uploading**: Files are currently in the process of being uploaded, with an option to cancel using the (x) button in the top right corner.
- **processing**: Uploaded files are actively being processed on the server.
- **completed**: Files have been uploaded and processed successfully.
- **failed**: Unfortunately, some file uploads may not succeed.
- **cancelled**: File uploading have been cancelled by the user.

## Backend

Many open-source file upload solutions provide only frontend components, leaving a gap in the backend integration. We've bridged that gap with a robust backend API developed using Python FastAPI, hosted on AWS Lambda.

Explore the backend source code at [serverless-file-upload repository](https://github.com/limcheekin/serverless-file-upload) to seamlessly integrate the File Upload module into your projects.

We welcome your insights and contributions to enhance the backend API implementation for file uploads. If you have alternative approaches or know of other backend API implementations that excel in this context, your input would be greatly appreciated. Your valuable suggestions can help us continually improve and refine our implementation. Thank you for your collaboration!

## Getting Started

For help getting started with Flutter development, view the online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
