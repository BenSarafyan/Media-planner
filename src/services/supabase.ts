import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseUrl.startsWith('http')) {
  throw new Error('VITE_SUPABASE_URL must be a valid URL starting with http:// or https://');
}
if (!supabaseAnonKey || !supabaseAnonKey.startsWith('sb')) {
  throw new Error('VITE_SUPABASE_ANON_KEY appears to be missing or invalid');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
