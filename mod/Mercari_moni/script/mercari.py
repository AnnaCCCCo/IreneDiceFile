from mercari import mercari

mercari_api = mercari()

print('_' * 80)
print(mercari_api.name)
print(mercari_api.fetch_all_items(keyword='CHANEL')[0:10])
#print(mercari_api.get_item_info('https://www.mercari.com/jp/items/m88046246209/'))