import connexion
import six

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.models.lesson import Lesson  # noqa: E501
from swagger_server import util


def create_lesson(body):  # noqa: E501
    """Create a lesson for a subject

     # noqa: E501

    :param body: Lesson object that needs to be added to the store
    :type body: dict | bytes

    :rtype: ApiResponse
    """
    if connexion.request.is_json:
        body = Lesson.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'
