
function decrement(index) {
  var quantity = document.getElementById('order_ordered_items_attributes_' + index + '_quantity');
  quantity.value--;
}

function increment(index) {
  var quantity = document.getElementById('order_ordered_items_attributes_' + index + '_quantity');
  quantity.value++;
}