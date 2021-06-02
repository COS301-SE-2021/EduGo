import connexion
import six

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.models.create_virtual_entity_request import CreateVirtualEntityRequest  # noqa: E501
from swagger_server import util


def create_virtual_entity(body=None):  # noqa: E501
    """Create virtual entity for lesson

     # noqa: E501

    :param body: 
    :type body: dict | bytes

    :rtype: ApiResponse
    """
    if connexion.request.is_json:
        body = CreateVirtualEntityRequest.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'
