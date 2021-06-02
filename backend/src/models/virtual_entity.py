# coding: utf-8

from __future__ import absolute_import
from datetime import date, datetime  # noqa: F401

from typing import List, Dict  # noqa: F401

from swagger_server.models.base_model_ import Model
from swagger_server import util


class VirtualEntity(Model):
    """NOTE: This class is auto generated by the swagger code generator program.

    Do not edit the class manually.
    """
    def __init__(self, virtual_entity_id: int=None, virtual_entity_description: str=None, information: str=None, _3_d_model_id: int=None, quiz_id: int=None):  # noqa: E501
        """VirtualEntity - a model defined in Swagger

        :param virtual_entity_id: The virtual_entity_id of this VirtualEntity.  # noqa: E501
        :type virtual_entity_id: int
        :param virtual_entity_description: The virtual_entity_description of this VirtualEntity.  # noqa: E501
        :type virtual_entity_description: str
        :param information: The information of this VirtualEntity.  # noqa: E501
        :type information: str
        :param _3_d_model_id: The _3_d_model_id of this VirtualEntity.  # noqa: E501
        :type _3_d_model_id: int
        :param quiz_id: The quiz_id of this VirtualEntity.  # noqa: E501
        :type quiz_id: int
        """
        self.swagger_types = {
            'virtual_entity_id': int,
            'virtual_entity_description': str,
            'information': str,
            '_3_d_model_id': int,
            'quiz_id': int
        }

        self.attribute_map = {
            'virtual_entity_id': 'virtualEntity_id',
            'virtual_entity_description': 'virtualEntity_description',
            'information': 'information',
            '_3_d_model_id': '3DModel_id',
            'quiz_id': 'Quiz_id'
        }
        self._virtual_entity_id = virtual_entity_id
        self._virtual_entity_description = virtual_entity_description
        self._information = information
        self.__3_d_model_id = _3_d_model_id
        self._quiz_id = quiz_id

    @classmethod
    def from_dict(cls, dikt) -> 'VirtualEntity':
        """Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The virtualEntity of this VirtualEntity.  # noqa: E501
        :rtype: VirtualEntity
        """
        return util.deserialize_model(dikt, cls)

    @property
    def virtual_entity_id(self) -> int:
        """Gets the virtual_entity_id of this VirtualEntity.


        :return: The virtual_entity_id of this VirtualEntity.
        :rtype: int
        """
        return self._virtual_entity_id

    @virtual_entity_id.setter
    def virtual_entity_id(self, virtual_entity_id: int):
        """Sets the virtual_entity_id of this VirtualEntity.


        :param virtual_entity_id: The virtual_entity_id of this VirtualEntity.
        :type virtual_entity_id: int
        """

        self._virtual_entity_id = virtual_entity_id

    @property
    def virtual_entity_description(self) -> str:
        """Gets the virtual_entity_description of this VirtualEntity.


        :return: The virtual_entity_description of this VirtualEntity.
        :rtype: str
        """
        return self._virtual_entity_description

    @virtual_entity_description.setter
    def virtual_entity_description(self, virtual_entity_description: str):
        """Sets the virtual_entity_description of this VirtualEntity.


        :param virtual_entity_description: The virtual_entity_description of this VirtualEntity.
        :type virtual_entity_description: str
        """

        self._virtual_entity_description = virtual_entity_description

    @property
    def information(self) -> str:
        """Gets the information of this VirtualEntity.


        :return: The information of this VirtualEntity.
        :rtype: str
        """
        return self._information

    @information.setter
    def information(self, information: str):
        """Sets the information of this VirtualEntity.


        :param information: The information of this VirtualEntity.
        :type information: str
        """

        self._information = information

    @property
    def _3_d_model_id(self) -> int:
        """Gets the _3_d_model_id of this VirtualEntity.


        :return: The _3_d_model_id of this VirtualEntity.
        :rtype: int
        """
        return self.__3_d_model_id

    @_3_d_model_id.setter
    def _3_d_model_id(self, _3_d_model_id: int):
        """Sets the _3_d_model_id of this VirtualEntity.


        :param _3_d_model_id: The _3_d_model_id of this VirtualEntity.
        :type _3_d_model_id: int
        """

        self.__3_d_model_id = _3_d_model_id

    @property
    def quiz_id(self) -> int:
        """Gets the quiz_id of this VirtualEntity.


        :return: The quiz_id of this VirtualEntity.
        :rtype: int
        """
        return self._quiz_id

    @quiz_id.setter
    def quiz_id(self, quiz_id: int):
        """Sets the quiz_id of this VirtualEntity.


        :param quiz_id: The quiz_id of this VirtualEntity.
        :type quiz_id: int
        """

        self._quiz_id = quiz_id
