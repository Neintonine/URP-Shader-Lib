#define CHECK_RADIUS 5

float rand3dTo1d(float3 value, float3 dotDir = float3(12.9898, 78.233, 37.719)){
	//make value smaller to avoid artefacts
	float3 smallValue = sin(value);
	//get scalar value from 3d vector
	float random = dot(smallValue, dotDir);
	//make value more random by making it bigger and then taking the factional part
	random = frac(sin(random) * 143758.5453);
	return random;
}
float3 rand3dTo3d(float3 value){
	return float3(
		rand3dTo1d(value, float3(12.989, 78.233, 37.719)),
		rand3dTo1d(value, float3(39.346, 11.135, 83.155)),
		rand3dTo1d(value, float3(73.156, 52.235, 09.151))
	);
}

float ManhattanVoronoiDistance_float(float3 cellPos, float3 pixelPos)
{
	return abs(cellPos.x - pixelPos.x) + abs(cellPos.y - pixelPos.y) + abs(cellPos.z - pixelPos.z);
}

void CalculateManhattanVoronoi_float(float3 pos, float smoothness, out float finalCellRandom, out float minDistance)
{
	float3 baseCell = floor(pos);

	minDistance = 10;
	finalCellRandom = 0;
	
	for(int x = -CHECK_RADIUS; x <= CHECK_RADIUS; x++)
	{
		for(int y = -CHECK_RADIUS; y <= CHECK_RADIUS; y++)
		{
			for(int z = -CHECK_RADIUS; z <= CHECK_RADIUS; z++)
			{
				float3 cell = baseCell + float3(x,y,z);
				float3 cellPos = cell + rand3dTo3d(cell);
				float distance = ManhattanVoronoiDistance_float(cellPos, pos);

				float smoothVal = smoothstep(-1.0, 1.0, (minDistance - distance) / smoothness);

				minDistance = lerp(minDistance, distance, smoothVal);
				finalCellRandom = lerp(finalCellRandom, rand3dTo1d(cell), smoothVal);
			}
		}
	}
}

void ManhattanVoronoi_float(float3 pos, float octaves, float weightDivider, float scaleMultiplier, float smoothness, out float cell, out float distance) {
	cell = 0;
	distance = 0;

	float finalOctaveWeight = frac(octaves);
	finalOctaveWeight = finalOctaveWeight > 0 ? finalOctaveWeight : 1;
	octaves = ceil(octaves);
	float weight = 1;
	float scale = 1;
	for (int octave = 0; octave < octaves; octave++)
	{
		float3 newPos = pos * scale;
		
		float finalCell;
		float minDistance;
		CalculateManhattanVoronoi_float(newPos, smoothness, finalCell, minDistance);

		if (octave == octaves - 1)
		{
			weight *= finalOctaveWeight;
		}
		
		cell = lerp(cell, finalCell, weight);
		distance = lerp(distance, minDistance, weight);
		
		scale *= scaleMultiplier;
		weight /= weightDivider;
	}
}