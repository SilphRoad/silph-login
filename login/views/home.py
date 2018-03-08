from .common import (
    web,
    routes,
)


@routes.view('/')
class HomeView(web.View):
    async def get(self):
        return web.Response(text='Hello World')

