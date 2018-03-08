import views


def setup(app):
    app.router.add_routes(views.routes)
