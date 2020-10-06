$(document).on('turbolinks:load', function() {
  return $('#material_postcode').jpostal({
    postcode: ['#material_postcode'],
    address: {
      '#material_prefecture_code': '%3',
      '#material_address_city': '%4',
      '#material_address_street': '%5%6%7',
    },
  });
});