from PIL import Image
from os import listdir
from os.path import join


in_path = 'data/sprites/color'
out_path = 'data/sprites/grayscale'


for file in listdir(in_path):
    img = Image.open(join(in_path, file)).convert('LA')
    img.save(join(out_path, file))
