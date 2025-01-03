function PlanetsLib:planet_extend(configs)
    if not configs[1] then
        configs = { configs }
    end

    local planets = {}
    for _, config in ipairs(configs) do
        PlanetsLib.verify_config_fields(config)

        local planet = {
            label_orientation = config.orbit.label_orientation,
        }

        PlanetsLib.set_position_from_orbit(planet, config.orbit)

        for k, v in pairs(config) do -- This will not include distance, orientation due to validity checks.
            planet[k] = v
        end

        if config.planet_type == "moon" then
            planet.subgroup = "satellites"
        end

        table.insert(planets, planet)
    end

    data:extend(planets)
    return planets
end

function PlanetsLib.set_position_from_orbit(planet, orbit)
    if orbit.parent == "star" then
        planet.distance = orbit.distance
        planet.orientation = orbit.orientation
    else
        local parent = data.raw.planet[orbit.parent]
        local parent_distance = parent.distance
        local parent_orientation = parent.orientation

        local parent_angle = parent_orientation * 2 * math.pi
        local orbit_angle = orbit.orientation * 2 * math.pi

        local px = parent_distance * math.cos(parent_angle)
        local py = parent_distance * math.sin(parent_angle)
        local ox = orbit.distance * math.cos(orbit_angle)
        local oy = orbit.distance * math.sin(orbit_angle)

        local x = px + ox
        local y = py + oy

        planet.distance = math.sqrt(x * x + y * y)
        planet.orientation = math.atan2(y, x) / (2 * math.pi)
        if planet.orientation < 0 then planet.orientation = planet.orientation + 1 end
        if planet.orientation > 1 then planet.orientation = planet.orientation - 1 end
    end
end

function PlanetsLib.verify_config_fields(config)
    if config.distance then
        error(
            "PlanetsLib:planet_extend() - 'distance' should be specified in the 'orbit' field. See the PlanetsLib documentation.")
    end
    if config.orientation then
        error(
            "PlanetsLib:planet_extend() - 'orientation' should be specified in the 'orbit' field. See the PlanetsLib documentation.")
    end
    if config.label_orientation then
        error(
            "PlanetsLib:planet_extend() - 'label_orientation' should be specified in the 'orbit' field. See the PlanetsLib documentation.")
    end
    if not config.orbit then
        error("PlanetsLib:planet_extend() - 'orbit' field is required. See the PlanetsLib documentation.")
    end
    if not config.orbit.parent then
        error("PlanetsLib:planet_extend() - 'orbit.parent' field is required with value e.g. 'star'.")
    end
    if not config.planet_type then
        error(
            "PlanetsLib:planet_extend() - 'planet_type' field is required. Current allowed values: 'planet', 'moon', 'star'.")
    end
end

function PlanetsLib.is_space_location(planet)
    if not planet then return false end
    return planet.type == "planet" or planet.type == "space-location"
end

--- Clones music tracks from source_planet to target_planet.
--- Does not overwrite existing music for target_planet.
function PlanetsLib.steal_music(source_planet, target_planet)
    assert(PlanetsLib.is_space_location(source_planet),
        "PlanetsLib:steal_music() - Invalid parameter 'source_planet'. Field is required to be either `space-location` or `planet` prototype.")
    assert(PlanetsLib.is_space_location(target_planet),
        "PlanetsLib:steal_music() - Invalid parameter 'target_planet'. Field is required to be either `space-location` or `planet` prototype.")

    for _, music in pairs(data.raw["ambient-sound"]) do
        if music.planet == source_planet.name or (music.track_type == "hero-track" and music.name:find(source_planet.name)) then
            local new_music = table.deepcopy(music)
            new_music.name = music.name .. "-" .. target_planet.name
            new_music.planet = target_planet.name
            data:extend {new_music}
        end
    end
end
