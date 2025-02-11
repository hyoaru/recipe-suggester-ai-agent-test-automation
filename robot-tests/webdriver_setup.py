import logging
from selenium import webdriver

logging.basicConfig(
  level=logging.INFO,
  format="[%(asctime)s] - [%(levelname)s] - %(message)s"
)

logging.info("Setting up webdrivers...")
webdriver.Chrome()
logging.info("Webdrivers setup successfully.")