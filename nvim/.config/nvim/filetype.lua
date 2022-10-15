vim.filetype.add({
    extension = {
        pnd = 'poweron',
        PND = 'poweron',
        po = 'poweron',
        PO = 'poweron',
        pro = 'poweron',
        PRO = 'poweron',
        def = 'poweron',
        DEF = 'poweron',
        sub = 'poweron',
        SUB = 'poweron',
        set = 'poweron',
        SET = 'poweron',
        fmp = 'poweron',
        FMP = 'poweron',
    },
    pattern = {
        ['.*.%d%d%d'] = 'poweron',
        ['/home/phil/projects/SourceControl/Main/Client Work/186 - USF/Staff Augmentation/*.*'] = 'poweron',
    }
})
