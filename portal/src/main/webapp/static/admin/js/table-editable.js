var TableEditable = function () {

    return {

        //main function to initiate the module
        init: function () {
            function restoreRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);

                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                    oTable.fnUpdate(aData[i], nRow, i, false);
                }

                oTable.fnDraw();
            }

            function editRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                jqTds[0].innerHTML = '<input type="text" class="m-wrap small" name="goodsName"  style="width:5%;" >';
                jqTds[1].innerHTML = '<input type="file" class="col-xs-10 col-sm-5" name="goodsPicture" style="width:120px;" >';
                jqTds[2].innerHTML = '<input type="text" class="m-wrap small" name="originalPrice" style="width:5%;" >';
                jqTds[3].innerHTML = '<input type="text" class="m-wrap small" name="limitPrice" style="width:5%;" >';
                jqTds[4].innerHTML = '<input type="text" class="m-wrap small" name="categoryCode" style="width:5%;" >';
                jqTds[5].innerHTML = '<input type="text" class="m-wrap small" name="colorDescription" style="width:5%;" >';
                jqTds[6].innerHTML = '<input type="text" class="m-wrap small" name="brandDescription" style="width:5%;" >';
                jqTds[7].innerHTML = '<input type="text" class="m-wrap small" name="description" style="width:5%;" >';
                jqTds[8].innerHTML = '<input type="text" class="m-wrap small" name="quantity" style="width:5%;" value="' + aData[8] + '">';
            }

            function saveRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate(jqInputs[4].value, nRow, 4, false);
                oTable.fnUpdate(jqInputs[5].value, nRow, 5, false);
                oTable.fnUpdate(jqInputs[6].value, nRow, 6, false);
                oTable.fnUpdate(jqInputs[7].value, nRow, 7, false);
                oTable.fnUpdate(jqInputs[8].value, nRow, 8, false);
                oTable.fnUpdate('<a class="delete1" href="">删除</a>', nRow, 9, false);
                oTable.fnDraw();
            }

            function cancelEditRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 4, false);
                oTable.fnDraw();
            }

            var oTable = $('#sample_editable_1').dataTable({
                "aLengthMenu": [
                    [5, 15, 20, -1],
                    [5, 15, 20, "All"] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 5,
                "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sPaginationType": "bootstrap",
                "oLanguage": {
                    "sLengthMenu": "_MENU_ 个/页",
                    "oPaginate": {
                        "sPrevious": "前一页",
                        "sNext": "后一页"
                    }
                },
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [0]
                }
                ]
            });

            jQuery('#sample_editable_1_wrapper .dataTables_filter input').addClass("m-wrap medium"); // modify table search input
            jQuery('#sample_editable_1_wrapper .dataTables_length select').addClass("m-wrap small"); // modify table per page dropdown
            jQuery('#sample_editable_1_wrapper .dataTables_length select').select2({
                showSearchInput : false //hide search box with special css class
            }); // initialzie select2 dropdown

            var nEditing = null;

            $('#sample_editable_1_new').click(function (e) {
                e.preventDefault();
                var aiNew = oTable.fnAddData(['', '', '', '','','','','','',
                    '<a class="edit" href="" >添加</a>'
                ]);
                var nRow = oTable.fnGetNodes(aiNew[0]);
                editRow(oTable, nRow);
                nEditing = nRow;
            });


            $('#sample_editable_1 a.delete').live('click', function (e) {
                e.preventDefault();

                if (confirm("亲，确定要删除这条记录么 ?") == false) {
                    return;
                }

                var nRow = $(this).parents('tr')[0];
                var jqInputs = $('input', nRow);
                alert(jqInputs[0]);
                oTable.fnDeleteRow(nRow);
                alert("删除成功啦！");
            });

            $('#sample_editable_1 a.cancel').live('click', function (e) {
                e.preventDefault();
                if ($(this).attr("data-mode") == "new") {
                    var nRow = $(this).parents('tr')[0];
                    oTable.fnDeleteRow(nRow);
                } else {
                    restoreRow(oTable, nEditing);
                    nEditing = null;
                }
            });

            $('#sample_editable_1 a.edit').live('click', function (e) {
                e.preventDefault();

                /* Get the row as a parent of the link that was clicked on */
                var nRow = $(this).parents('tr')[0];


                if (nEditing !== null && nEditing != nRow) {
                    /* Currently editing - but not this row - restore the old before continuing to edit mode */
                    restoreRow(oTable, nEditing);
                    editRow(oTable, nRow);
                    nEditing = nRow;
                } else if (nEditing == nRow ) {
                    /* Editing this row and want to save it */
                    var jqInputs = $('input', nRow);
                    $.ajax({
                        type:"post",

                        url:"http://localhost:8080/admin/addGoods!addGoods.action",
                        data:{
                            goodsName:jqInputs[0].value + "",
                            goodsPicture:jqInputs[1].value + "",
                            originalPrice:jqInputs[2].value + "",
                            limitPrice:jqInputs[3].value + "",
                            categoryCode:jqInputs[4].value + "",
                            colorDescription:jqInputs[5].value + "",
                            brandDescription:jqInputs[6].value + "",
                            description:jqInputs[7].value + "",
                            quantity:jqInputs[8].value + ""
                        },
                        dataType:"json",
                        success:function(){
                            saveRow(oTable, nEditing);
                            nEditing = null;
                        }
                    });
                } else {
                    /* No edit in progress - let's start one */
                    editRow(oTable, nRow);
                    nEditing = nRow;
                }
            });
        }

    };

}();