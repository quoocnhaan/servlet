function submitCategory(cat) {
    const form = document.getElementById('filterForm');
    form.category.value = cat;
    form.page.value = 1;
    form.submit();
}



document.addEventListener('DOMContentLoaded', function () {
    const minusBtn = document.querySelector('.qty-btn.minus');
    const plusBtn = document.querySelector('.qty-btn.plus');
    const qtyInput = document.querySelector('.quantity-input');
    plusBtn.addEventListener('click', () => {
        let val = parseInt(qtyInput.value);
        qtyInput.value = val + 1;
    });
    minusBtn.addEventListener('click', () => {
        let val = parseInt(qtyInput.value);
        if (val > 1) {
            qtyInput.value = val - 1;
        }
    });
    qtyInput.addEventListener('input', function () {
        if (this.value < 1)
            this.value = 1;
    });
});




function closeProductModal() {
    document.getElementById('productModal').style.display = 'none';
}


function openOrderModal(id) {
    document.getElementById(id).classList.add('show');
}

function closeOrderModal(id) {
    document.getElementById(id).classList.remove('show');
}
