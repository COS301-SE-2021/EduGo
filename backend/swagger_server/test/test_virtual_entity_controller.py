# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.api_response import ApiResponse  # noqa: E501
from swagger_server.test import BaseTestCase


class TestVirtualEntityController(BaseTestCase):
    """VirtualEntityController integration test stubs"""

    def test_createvirtual_entity(self):
        """Test case for createvirtual_entity

        Create virtual entity for lesson
        """
        response = self.client.open(
            '/Gang-of-Five/EduGo/1.0.0/virtualEntity/createVirtualEntity',
            method='POST')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
