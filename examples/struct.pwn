//----------------------------------------------------------
//
// GRAND LARCENY common functions include.
//
//----------------------------------------------------------

stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock strrest(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim) {
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}

stock isNumeric(const string[])
{
  new length=strlen(string);
  if (length==0) return false;
  for (new i = 0; i < length; i++)
    {
      if (
            (string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
             || (string[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (string[i]=='+' && i!=0)                                             // A '+' but not at first.
         ) return false;
    }
  if (length==1 && (string[0]=='-' || string[0]=='+')) return false;
  return true;
}

stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

stock PlaySoundForAll(soundid, Float:x, Float:y, Float:z)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}

stock PlaySoundForPlayersInRange(soundid, Float:range, Float:x, Float:y, Float:z)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,range,x,y,z))
	    {
		    PlayerPlaySound(i, soundid, x, y, z);
	    }
	}
}

#define RETURN_USER_FAILURE -1
#define RETURN_USER_MULTIPLE -2

stock ReturnUser(text[])
{
	new pos = 0;
	new userid = RETURN_USER_FAILURE;
		
	while(text[pos] < 0x21) { // Strip out leading spaces
		if(text[pos] == 0) return RETURN_USER_FAILURE; // No passed text
		pos++;
	}
		
	if(isNumeric(text[pos])) { // Check whole passed string
		userid = strval(text[pos]);
		if(userid >=0 && userid < MAX_PLAYERS)
		{
			if(IsPlayerConnected(userid)) return userid;
			return RETURN_USER_FAILURE;
		}
	}
	
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME+1];
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof(name));
			if(strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{
				if(len == strlen(name)) { // Exact match
					return i;
				}
				else { // Partial match
					count++;
					userid = i;
				}
			}
		}
	}
	
	if(!count) return RETURN_USER_FAILURE;
	if(count > 1) return RETURN_USER_MULTIPLE;
	
	return userid;
}
