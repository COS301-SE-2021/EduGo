# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.test import BaseTestCase


class TestSubjectController(BaseTestCase):
    """SubjectController integration test stubs"""

    def test_create_subject(self):
        """Test case for create_subject

        Create subject for organization
        """
        response = self.client.open(
            '/Gang-of-Five/EduGo/1.0.0/subject/createSubject',
            method='POST')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
