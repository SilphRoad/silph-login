from aiohttp import web
import routes

app = web.Application()
routes.setup(app)

web.run_app(app, host='0.0.0.0', port=8080)
