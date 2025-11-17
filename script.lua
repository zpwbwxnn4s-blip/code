--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ScriptFinder"
gui.ResetOnSpawn = false

----------------------------------------------------------
-- LOADING SCREEN
----------------------------------------------------------
local loading = Instance.new("Frame")
loading.Size = UDim2.new(0, 350, 0, 80)
loading.Position = UDim2.new(0.7, 0,
