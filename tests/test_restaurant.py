from unittest import TestCase
import unittest

from bson.objectid import ObjectId
from mock import patch
import asyncio


import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from src import app_v2

class TestRestaurant(TestCase):

    @patch('src.app_v2.read_items')
    async def test_get_restaurant_returns_a_list(self):
        data = app_v2.read_items()
        self.assertEqual(list, type(data))


    @patch('src.app_v2.read_item')
    async def test_get_resturant_returns_a_unique_element_list(self):
        data = app_v2.read_item("55f14312c7447c3da7051b39")
        self.assertEqual(len(data), 1)
        self.assertTrue(data[0].get("type_of_food") == "Chinese")

if __name__ == '__main__':
    unittest.main()
