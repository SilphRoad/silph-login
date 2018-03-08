from .common import (
    web,
    routes,
)


@routes.view('/access-token')
class TokenView(web.View):
    async def get(self):
        pass
