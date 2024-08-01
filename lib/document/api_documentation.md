# API Documentation

## Authentication

### Login
- **Endpoint**: `/api/auth/login`
- **Method**: `POST`
- **Description**: Authenticates a user and returns an access token.
- **Request Body**:
  ```json
  {
    "username": "user",
    "password": "password"
  }
