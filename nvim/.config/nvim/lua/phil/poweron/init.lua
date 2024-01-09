local M = {}

local symConfigurations = {
    {
        name = "SMOPROSVS-SYM700",
        symNumber = "700",
        hostname = "https://smoprosvs.jhacorp.com",
        port = "42700",
        aixUserName = "peagleson",
        aixPassword = os.getenv("SMOPROSVS_PASS"),
        symUserNumber = "0",
        symPassword = "0",
        device = os.getenv("HOSTNAME"),
        deviceIp = os.getenv("HOSTIP"),
    },
    {
        name = "SMOEPIPVC94-SYM777",
        symNumber = "777",
        hostname = "https://smoepipvc94.jhacorp.com",
        port = "42777",
        aixUserName = "peagleso",
        aixPassword = os.getenv("SMOPROSVS_PASS"),
        symUserNumber = "0",
        symPassword = "Symitar#2",
        device = os.getenv("HOSTNAME"),
        deviceIp = os.getenv("HOSTIP"),
    },
}

local function handleValidatePoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Validate PowerOn - Choose Sym",
    }, function(choice)
        if choice then
            vim.lsp.buf_request(buffnr, "workspace/executeCommand", {
                command = "lsp.validatePoweron",
                arguments = {
                    {
                        symConfigName = choice,
                        uri = uri,
                    },
                },
            }, nil)
        end
    end)
end

local function handleInstallPoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Install PowerOn - Choose Sym",
    }, function(choice)
        if choice then
            vim.lsp.buf_request(buffnr, "workspace/executeCommand", {
                command = "lsp.installPoweron",
                arguments = {
                    {
                        symConfigName = choice,
                        uri = uri,
                    },
                },
            }, nil)
        end
    end)
end

local function handleDeployPoweron(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    local opts = {
        require("telescope.themes").get_dropdown({}),
        title = "Choose Sym(s)",
    }
    My_custom_picker(opts, symConfigs, function(results)
        local selected = {}
        for _, res in ipairs(results) do
            for _, item in ipairs(res) do
                table.insert(selected, item)
            end
        end

        if #selected == 0 then
            return
        end

        vim.lsp.buf_request(buffnr, "workspace/executeCommand", {
            command = "lsp.deployPoweron",
            arguments = {
                {
                    deployToSyms = selected,
                    uri = uri,
                },
            },
        }, nil)
    end)
end

local function selectPoweron(poweronList, symConfigName)
    local opts = {
        require("telescope.themes").get_dropdown({}),
        title = "Choose Poweron(s)",
    }

    My_custom_picker(opts, poweronList, function(results)
        local selected = {}
        for _, res in ipairs(results) do
            for _, item in ipairs(res) do
                table.insert(selected, item)
            end
        end

        if #selected == 0 then
            return
        end

        vim.lsp.buf_request(0, "workspace/executeCommand", {
            command = "lsp.importPowerons",
            arguments = {
                {
                    symConfigName = symConfigName,
                    poweronList = selected,
                },
            },
        })
    end)
end

local function getPoweronList(buffnr)
    local symConfigs = {}
    for i in pairs(symConfigurations) do
        symConfigs[i] = symConfigurations[i].name
    end
    local uri = "file://" .. vim.fn.expand("%:p")
    uri = uri:gsub("%s", "%%20")
    uri = uri:gsub("\\", "/")

    vim.ui.select(symConfigs, {
        prompt = "Import PowerOn - Choose Sym",
    }, function(configChoice)
        if configChoice then
            vim.ui.input({ prompt = "Search (*=any string, ?=any char):" }, function(searchString)
                vim.lsp.buf_request(buffnr, "workspace/executeCommand", {
                    command = "lsp.getPoweronList",
                    arguments = {
                        {
                            searchFilter = searchString,
                            symConfigName = configChoice,
                        },
                    },
                }, function(err, res, _)
                    if err then
                        vim.notify(err.message, vim.log.levels.ERROR)
                        return
                    end
                    local poweronList = res["TaskManager_PowerOnList"]["poweronList"]
                    if poweronList == nil then
                        vim.notify("No PowerOn found", vim.log.levels.ERROR)
                        return
                    end
                    selectPoweron(poweronList, configChoice)
                end)
            end)
        end
    end)
end

local function handleDataTypeNotification(_, _, ctx)
    local uri = ctx["params"]["arguments"][1]["uri"]
    local varName = ctx["params"]["arguments"][1]["varName"]
    local bufnr = ctx.bufnr
    vim.ui.select({
        "CHARACTER",
        "CODE",
        "DATE",
        "FLOAT",
        "MONEY",
        "NUMBER",
        "RATE",
    }, {
        prompt = "Choose Data type",
    }, function(choice)
        if choice then
            vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
                command = "lsp.addVarToDefine",
                arguments = {
                    {
                        dataType = choice,
                        varName = varName,
                        uri = uri,
                    },
                },
            }, nil)
        end
    end)
end

M.handleValidatePoweron = handleValidatePoweron
M.symConfigurations = symConfigurations
M.handleInstallPoweron = handleInstallPoweron
M.handleDeployPoweron = handleDeployPoweron
M.selectPoweron = selectPoweron
M.getPoweronList = getPoweronList
M.handleDataTypeNotification = handleDataTypeNotification

return M
