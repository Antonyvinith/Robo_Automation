import requests
import time

start_time = time.time()
response = requests.get("https://jsonplaceholder.typicode.com/users/1")
end_time = time.time()

print(f"Status Code: {response.status_code}")
print(f"Response Time: {end_time - start_time} seconds")


