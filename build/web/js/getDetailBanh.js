function showDetailBanh(banhId, contextPath = '') {
    var base = contextPath || '';
    $.ajax({
        url: base + '/getDetailAjax',
        method: 'GET',
        data: { id: banhId },
        dataType: 'json',
        success: function(data) {
            if (data.error) {
                alert('Không tìm thấy thông tin bánh!');
                return;
            }

            $('#modal-img').attr('src', data.image || data.img || '');
            $('#modal-des').text(data.detail || data.description || '');
            $('#modal-price').text('Giá: ' + new Intl.NumberFormat('vi-VN').format(data.price || 0) + ' đ');
            $('#modal-book-btn').attr('href', base + '/banh?id=' + data.id);
            $('#banhModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.error('getDetailAjax error', status, error);
            alert('Lỗi khi lấy thông tin bánh!');
        }
    });
}
