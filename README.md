# Web Messages - Complete Application Stack

This repository provides an easy way to run the complete Web Messages (OneTimeChat) application stack locally using Docker Compose. It orchestrates three separate services:

- **Database** ([web-messages-db](https://github.com/appdevjohn/web-messages-db)) - PostgreSQL database with schema setup
- **Backend Service** ([web-messages-service](https://github.com/appdevjohn/web-messages-service)) - Express.js REST API with Socket.IO for real-time messaging
- **Frontend PWA** ([web-messages-pwa](https://github.com/appdevjohn/web-messages-pwa)) - React Progressive Web App

## Features

- Send group messages anonymously without account creation
- Link-based conversation access
- Real-time messaging via Socket.IO
- Conversations automatically deleted after 30 days of inactivity
- Optional user authentication for creating conversations
- Optional email verification and password reset

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- [Make](https://www.gnu.org/software/make/) (usually pre-installed on macOS/Linux)
- Git

## Quick Start

1. Clone this repository:

   ```bash
   git clone https://github.com/appdevjohn/web-messages
   cd web-messages
   ```

2. Copy the environment file and configure it:

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and set at minimum:

   - `TOKEN_SECRET` - A secure random string for JWT signing
   - Other settings as needed (see Configuration section below)

3. Run the setup command:

   ```bash
   make setup
   ```

   This will:

   - Clone the three project repositories
   - Build Docker images for all services

4. Start the application:

   ```bash
   make start
   ```

5. Access the application:
   - **Frontend**: http://localhost:3000
   - **Backend API**: http://localhost:8000
   - **Database**: postgresql://localhost:5432

## Available Commands

Run `make help` to see all available commands:

| Command        | Description                                |
| -------------- | ------------------------------------------ |
| `make setup`   | Clone repositories and build Docker images |
| `make clone`   | Clone the three project repositories       |
| `make build`   | Build all Docker images                    |
| `make start`   | Start all services                         |
| `make stop`    | Stop all services                          |
| `make restart` | Restart all services                       |
| `make logs`    | View logs from all services                |
| `make pull`    | Pull latest changes from all repositories  |
| `make clean`   | Remove cloned repos and Docker volumes     |

## Configuration

### Required Environment Variables

Edit the `.env` file to configure the application. The most important settings are:

**Security:**

- `TOKEN_SECRET` - **REQUIRED** - JWT signing secret (use a long random string)

**Database:**

- `POSTGRES_USER` - Database username (default: `user`)
- `POSTGRES_PASSWORD` - Database password (default: `password1`)
- `POSTGRES_DB` - Database name (default: `messages_db`)

**Application:**

- `APP_NAME` - Application name displayed to users (default: `OneTimeChat`)
- `APP_BASE_URL` - Frontend URL (default: `http://localhost:3000`)
- `BASE_URL` - Backend URL (default: `http://localhost:8000`)

### Optional Features

**Email Verification:**
Set `VERIFY_USERS=true` and `SEND_EMAILS=true` to enable email verification. Requires:

- `SENDGRID_API_KEY` - Your SendGrid API key

**Image Uploads:**

- `ENABLE_UPLOADS` - Set to `true` to allow image uploads in messages (default: `false`)

## Development Workflow

### Making Changes

The three service directories (`web-messages-db`, `web-messages-service`, `web-messages-pwa`) are separate Git repositories. To make changes:

1. Navigate to the specific service directory
2. Make your changes
3. Rebuild the affected service:
   ```bash
   make build
   make restart
   ```

### Updating to Latest Version

To pull the latest changes from all repositories:

```bash
make pull
make build
make restart
```

### Viewing Logs

To view logs from all services:

```bash
make logs
```

To view logs from a specific service:

```bash
docker-compose logs -f service-name
```

Service names: `db`, `service`, `pwa`

## Troubleshooting

### Services won't start

1. Check if ports 3000, 5432, or 8000 are already in use:

   ```bash
   lsof -i :3000
   lsof -i :5432
   lsof -i :8000
   ```

2. Check service logs:
   ```bash
   make logs
   ```

### Database connection errors

1. Ensure the database service is healthy:

   ```bash
   docker-compose ps
   ```

2. Check database logs:

   ```bash
   docker-compose logs db
   ```

3. Verify environment variables in `.env` match between services

### Frontend can't connect to backend

1. Verify `VITE_API_BASE_URL` in `.env` is set to `http://localhost:8000`
2. Check that the backend service is running:
   ```bash
   docker-compose ps service
   ```
3. Test the backend directly:
   ```bash
   curl http://localhost:8000/health-check
   ```

## Production Deployment

This setup is designed for local development. For production deployment:

1. Update environment variables in `.env` for production values
2. Set secure passwords and secrets
3. Configure proper CORS settings
4. Use a reverse proxy (nginx) for the frontend
5. Enable SSL/TLS certificates
6. Set up proper database backups
7. Configure email service (SendGrid) if using email features

## License

Each component has its own license. Refer to the individual repositories for details.

## Contributing

To contribute to any of the components, please refer to their respective repositories:

- [web-messages-db](https://github.com/appdevjohn/web-messages-db)
- [web-messages-service](https://github.com/appdevjohn/web-messages-service)
- [web-messages-pwa](https://github.com/appdevjohn/web-messages-pwa)

## Support

For issues related to:

- **Database setup** - Open an issue in [web-messages-db](https://github.com/appdevjohn/web-messages-db/issues)
- **Backend API** - Open an issue in [web-messages-service](https://github.com/appdevjohn/web-messages-service/issues)
- **Frontend UI** - Open an issue in [web-messages-pwa](https://github.com/appdevjohn/web-messages-pwa/issues)
- **This integration** - Open an issue in this repository
