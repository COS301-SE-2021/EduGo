# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.models.lesson import Lesson  # noqa: E501
from swagger_server.test import BaseTestCase


class TestLessonController(BaseTestCase):
    """LessonController integration test stubs"""

    def test_create_lesson(self):
        """Test case for create_lesson

        Create a lesson for a subject
        """
        body = Lesson()
        response = self.client.open(
            '/Gang-of-Five/EduGo/1.0.0/lesson/createLesson',
            method='POST',
            data=json.dumps(body),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
