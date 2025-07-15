import sys
import pyttsx3
import speech_recognition as sr
import traceback
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QThread

print("=== JARVIS Debug Script ===")

# Test 1: Basic TTS functionality
print("\n1. Testing TTS functionality...")
try:
    engine = pyttsx3.init('sapi5')
    voices = engine.getProperty('voices')
    engine.setProperty('voice', voices[0].id)
    print(f"TTS Engine initialized. Available voices: {len(voices)}")
    engine.say("TTS test successful")
    engine.runAndWait()
    print("✓ TTS working correctly")
except Exception as e:
    print(f"✗ TTS Error: {e}")
    traceback.print_exc()

# Test 2: Speech Recognition
print("\n2. Testing Speech Recognition...")
try:
    listener = sr.Recognizer()
    with sr.Microphone() as source:
        print("Microphone detected")
        listener.adjust_for_ambient_noise(source, duration=1)
        print("✓ Speech Recognition setup successful")
except Exception as e:
    print(f"✗ Speech Recognition Error: {e}")
    traceback.print_exc()

# Test 3: PyQt5 functionality
print("\n3. Testing PyQt5...")
try:
    app = QApplication(sys.argv)
    print("✓ PyQt5 application created successfully")
    app.quit()
except Exception as e:
    print(f"✗ PyQt5 Error: {e}")
    traceback.print_exc()

# Test 4: Import MainThread
print("\n4. Testing MainThread import...")
try:
    from JARVIS import MainThread
    print("✓ MainThread imported successfully")
except Exception as e:
    print(f"✗ MainThread Import Error: {e}")
    traceback.print_exc()

# Test 5: Test talk method specifically
print("\n5. Testing talk method...")
try:
    class TestTalk:
        def __init__(self):
            self.engine = pyttsx3.init('sapi5')
            voices = self.engine.getProperty('voices')
            self.engine.setProperty('voice', voices[0].id)
        
        def talk(self, text):
            try:
                print(f"JARVIS says: {text}")
                self.engine.say(text)
                self.engine.runAndWait()
            except Exception as e:
                print(f"Error in talk(): {e}")
    
    test_talk = TestTalk()
    test_talk.talk("Hello, this is a test message")
    print("✓ Talk method working correctly")
except Exception as e:
    print(f"✗ Talk method Error: {e}")
    traceback.print_exc()

print("\n=== Debug Complete ===")
