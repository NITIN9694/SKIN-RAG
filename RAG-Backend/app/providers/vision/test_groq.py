from app.providers.vision.groq_provider import GroqVisionProvider

vision = GroqVisionProvider()

result = vision.analyze("uploads/skin_image.jpg")

print(result)