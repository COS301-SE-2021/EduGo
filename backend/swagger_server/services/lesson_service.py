from swagger_server.models.api_response import ApiResponse
from swagger_server.models.create_lesson_request import CreateLessonRequest

def createLesson(request: CreateLessonRequest) -> ApiResponse:
    response = ApiResponse(request.title)
    return response