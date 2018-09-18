import scrapy

class BlogSpider(scrapy.Spider):
    name = 'characterspider'
    start_urls = ['https://fr.wikipedia.org/wiki/Cat%C3%A9gorie:Personnage_d\'animation']

    def parse(self, response):
        for title in response.css('div#mw-pages div.mw-content-ltr li'):
            yield {'character': title.css('a ::text').extract_first()}
