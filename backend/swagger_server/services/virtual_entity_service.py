from swagger_server.models.api_response import ApiResponse
from swagger_server.models.create_virtual_entity_request import CreateVirtualEntityRequest

def createVirtualEntity(request: CreateVirtualEntityRequest) -> ApiResponse:
    response = ApiResponse()
    return response