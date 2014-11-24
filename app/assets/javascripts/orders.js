$( document ).ready(function() {
    $('.quantity_add').click(function () {
        var index = this.getAttribute('data-item');
        var quantity = document.getElementById('order_ordered_items_attributes_' + index + '_quantity');
        quantity.value++;
        return false;
    });

    $('.quantity_subtract').click(function () {
        var index = this.getAttribute('data-item');
        var quantity = document.getElementById('order_ordered_items_attributes_' + index + '_quantity');
        quantity.value = Math.max((quantity.value - 1), 0);
        return false;
    });
});