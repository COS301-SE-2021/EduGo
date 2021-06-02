import connexion
import six

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.models.create_subject_request import CreateSubjectRequest  # noqa: E501
from swagger_server import util


def create_subject(body=None):  # noqa: E501
    """Create subject for organization

     # noqa: E501

    :param body: 
    :type body: dict | bytes

    :rtype: ApiResponse
    """
    if connexion.request.is_json:
        body = CreateSubjectRequest.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'
