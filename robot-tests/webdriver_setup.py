import logging
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager

logging.basicConfig(
  level=logging.INFO,
  format="[%(asctime)s] - [%(levelname)s] - %(message)s"
)

logging.info("Setting up webdrivers...")
chrome_driver_path = ChromeDriverManager().install()
logging.info(f"Chrome driver path: {chrome_driver_path}")
firefox_driver_path = GeckoDriverManager().install()
logging.info(f"Firefox driver path: {firefox_driver_path}")
logging.info("Webdrivers setup successfully.")