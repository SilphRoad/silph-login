from .common import (
    web,
    routes,
)


@routes.view('/authorize')
class AuthorizeView(web.View):
    async def get(self):
        pass

    async def post(self):
        pass
