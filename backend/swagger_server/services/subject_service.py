from swagger_server.models.api_response import ApiResponse
from swagger_server.models.create_subject_request import CreateSubjectRequest

def createStudent(request: CreateSubjectRequest) -> ApiResponse:
    response = ApiResponse()
    return response